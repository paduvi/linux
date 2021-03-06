/* extract-dialog.c generated by valac 0.30.0, the Vala compiler
 * generated from extract-dialog.vala, do not modify */

/* Copyright 2015 taprosoft
*
* This file is part of Gtar.
*
* Gtar is free software: you can redistribute it
* and/or modify it under the terms of the GNU General Public License as
* published by the Free Software Foundation, either version 3 of the
* License, or (at your option) any later version.
*
* Gtar is distributed in the hope that it will be
* useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
* Public License for more details.
*
* You should have received a copy of the GNU General Public License along
* with Gtar. If not, see http://www.gnu.org/licenses/.
*/

#include <glib.h>
#include <glib-object.h>
#include <gtk/gtk.h>
#include <stdlib.h>
#include <string.h>


#define TYPE_EXTRACT_DIALOG (extract_dialog_get_type ())
#define EXTRACT_DIALOG(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), TYPE_EXTRACT_DIALOG, ExtractDialog))
#define EXTRACT_DIALOG_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), TYPE_EXTRACT_DIALOG, ExtractDialogClass))
#define IS_EXTRACT_DIALOG(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), TYPE_EXTRACT_DIALOG))
#define IS_EXTRACT_DIALOG_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), TYPE_EXTRACT_DIALOG))
#define EXTRACT_DIALOG_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), TYPE_EXTRACT_DIALOG, ExtractDialogClass))

typedef struct _ExtractDialog ExtractDialog;
typedef struct _ExtractDialogClass ExtractDialogClass;
typedef struct _ExtractDialogPrivate ExtractDialogPrivate;
#define _g_object_unref0(var) ((var == NULL) ? NULL : (var = (g_object_unref (var), NULL)))
#define _g_error_free0(var) ((var == NULL) ? NULL : (var = (g_error_free (var), NULL)))

struct _ExtractDialog {
	GtkFileChooserDialog parent_instance;
	ExtractDialogPrivate * priv;
};

struct _ExtractDialogClass {
	GtkFileChooserDialogClass parent_class;
};

struct _ExtractDialogPrivate {
	GtkCheckButton* overwrite_file;
	GtkCheckButton* keep_directory;
	GtkRadioButton* all_files;
	GtkRadioButton* selected_files;
	GtkRadioButton* listed_files;
	GtkEntry* file_pattern;
};


static gpointer extract_dialog_parent_class = NULL;

GType extract_dialog_get_type (void) G_GNUC_CONST;
#define EXTRACT_DIALOG_GET_PRIVATE(o) (G_TYPE_INSTANCE_GET_PRIVATE ((o), TYPE_EXTRACT_DIALOG, ExtractDialogPrivate))
enum  {
	EXTRACT_DIALOG_DUMMY_PROPERTY
};
ExtractDialog* extract_dialog_new (GtkWindow* window, gint type);
ExtractDialog* extract_dialog_construct (GType object_type, GtkWindow* window, gint type);
gboolean extract_dialog_keep_structure (ExtractDialog* self);
gboolean extract_dialog_keep_old_files (ExtractDialog* self);
gchar* extract_dialog_get_pattern (ExtractDialog* self);
gint extract_dialog_get_extract_option (ExtractDialog* self);
static void extract_dialog_finalize (GObject* obj);


static gpointer _g_object_ref0 (gpointer self) {
	return self ? g_object_ref (self) : NULL;
}


ExtractDialog* extract_dialog_construct (GType object_type, GtkWindow* window, gint type) {
	ExtractDialog * self = NULL;
	GtkWindow* _tmp0_ = NULL;
	GtkBuilder* builder = NULL;
	GtkBuilder* _tmp1_ = NULL;
	GtkBox* option_box = NULL;
	GtkBuilder* _tmp4_ = NULL;
	GObject* _tmp5_ = NULL;
	GtkBox* _tmp6_ = NULL;
	GtkBox* content = NULL;
	GtkBox* _tmp7_ = NULL;
	GtkBox* _tmp8_ = NULL;
	GtkBox* _tmp9_ = NULL;
	GtkBox* _tmp10_ = NULL;
	GtkBuilder* _tmp11_ = NULL;
	GObject* _tmp12_ = NULL;
	GtkRadioButton* _tmp13_ = NULL;
	GtkBuilder* _tmp14_ = NULL;
	GObject* _tmp15_ = NULL;
	GtkRadioButton* _tmp16_ = NULL;
	GtkBuilder* _tmp17_ = NULL;
	GObject* _tmp18_ = NULL;
	GtkRadioButton* _tmp19_ = NULL;
	GtkBuilder* _tmp20_ = NULL;
	GObject* _tmp21_ = NULL;
	GtkCheckButton* _tmp22_ = NULL;
	GtkBuilder* _tmp23_ = NULL;
	GObject* _tmp24_ = NULL;
	GtkCheckButton* _tmp25_ = NULL;
	GtkBuilder* _tmp26_ = NULL;
	GObject* _tmp27_ = NULL;
	GtkEntry* _tmp28_ = NULL;
	GSList* group = NULL;
	GtkRadioButton* _tmp29_ = NULL;
	GSList* _tmp30_ = NULL;
	GtkRadioButton* _tmp31_ = NULL;
	GSList* _tmp32_ = NULL;
	GtkRadioButton* _tmp33_ = NULL;
	GSList* _tmp34_ = NULL;
	gint _tmp35_ = 0;
	GError * _inner_error_ = NULL;
	self = (ExtractDialog*) g_object_new (object_type, NULL);
	gtk_window_set_title ((GtkWindow*) self, "Choose extract location");
	gtk_file_chooser_set_action ((GtkFileChooser*) self, GTK_FILE_CHOOSER_ACTION_SELECT_FOLDER);
	_tmp0_ = window;
	gtk_window_set_transient_for ((GtkWindow*) self, _tmp0_);
	_tmp1_ = gtk_builder_new ();
	builder = _tmp1_;
	{
		GtkBuilder* _tmp2_ = NULL;
		_tmp2_ = builder;
		gtk_builder_add_from_file (_tmp2_, "ui/extra.ui", &_inner_error_);
		if (G_UNLIKELY (_inner_error_ != NULL)) {
			goto __catch5_g_error;
		}
	}
	goto __finally5;
	__catch5_g_error:
	{
		GError* e = NULL;
		const gchar* _tmp3_ = NULL;
		e = _inner_error_;
		_inner_error_ = NULL;
		_tmp3_ = e->message;
		g_error ("extract-dialog.vala:43: Unable to load file: %s", _tmp3_);
		_g_error_free0 (e);
	}
	__finally5:
	if (G_UNLIKELY (_inner_error_ != NULL)) {
		_g_object_unref0 (builder);
		g_critical ("file %s: line %d: uncaught error: %s (%s, %d)", __FILE__, __LINE__, _inner_error_->message, g_quark_to_string (_inner_error_->domain), _inner_error_->code);
		g_clear_error (&_inner_error_);
		return NULL;
	}
	_tmp4_ = builder;
	_tmp5_ = gtk_builder_get_object (_tmp4_, "extra_widgets");
	_tmp6_ = _g_object_ref0 (G_TYPE_CHECK_INSTANCE_TYPE (_tmp5_, gtk_box_get_type ()) ? ((GtkBox*) _tmp5_) : NULL);
	option_box = _tmp6_;
	_tmp7_ = (GtkBox*) gtk_dialog_get_content_area ((GtkDialog*) self);
	_tmp8_ = _g_object_ref0 (G_TYPE_CHECK_INSTANCE_TYPE (_tmp7_, gtk_box_get_type ()) ? ((GtkBox*) _tmp7_) : NULL);
	content = _tmp8_;
	_tmp9_ = content;
	_tmp10_ = option_box;
	gtk_box_pack_start (_tmp9_, (GtkWidget*) _tmp10_, FALSE, TRUE, (guint) 10);
	gtk_dialog_add_button ((GtkDialog*) self, "Cancel", (gint) GTK_RESPONSE_CANCEL);
	gtk_dialog_add_button ((GtkDialog*) self, "Extract", (gint) GTK_RESPONSE_ACCEPT);
	_tmp11_ = builder;
	_tmp12_ = gtk_builder_get_object (_tmp11_, "all_files");
	_tmp13_ = _g_object_ref0 (G_TYPE_CHECK_INSTANCE_TYPE (_tmp12_, gtk_radio_button_get_type ()) ? ((GtkRadioButton*) _tmp12_) : NULL);
	_g_object_unref0 (self->priv->all_files);
	self->priv->all_files = _tmp13_;
	_tmp14_ = builder;
	_tmp15_ = gtk_builder_get_object (_tmp14_, "selected_files");
	_tmp16_ = _g_object_ref0 (G_TYPE_CHECK_INSTANCE_TYPE (_tmp15_, gtk_radio_button_get_type ()) ? ((GtkRadioButton*) _tmp15_) : NULL);
	_g_object_unref0 (self->priv->selected_files);
	self->priv->selected_files = _tmp16_;
	_tmp17_ = builder;
	_tmp18_ = gtk_builder_get_object (_tmp17_, "file_pattern");
	_tmp19_ = _g_object_ref0 (G_TYPE_CHECK_INSTANCE_TYPE (_tmp18_, gtk_radio_button_get_type ()) ? ((GtkRadioButton*) _tmp18_) : NULL);
	_g_object_unref0 (self->priv->listed_files);
	self->priv->listed_files = _tmp19_;
	_tmp20_ = builder;
	_tmp21_ = gtk_builder_get_object (_tmp20_, "overwrite_files");
	_tmp22_ = _g_object_ref0 (G_TYPE_CHECK_INSTANCE_TYPE (_tmp21_, gtk_check_button_get_type ()) ? ((GtkCheckButton*) _tmp21_) : NULL);
	_g_object_unref0 (self->priv->overwrite_file);
	self->priv->overwrite_file = _tmp22_;
	_tmp23_ = builder;
	_tmp24_ = gtk_builder_get_object (_tmp23_, "keep_structure");
	_tmp25_ = _g_object_ref0 (G_TYPE_CHECK_INSTANCE_TYPE (_tmp24_, gtk_check_button_get_type ()) ? ((GtkCheckButton*) _tmp24_) : NULL);
	_g_object_unref0 (self->priv->keep_directory);
	self->priv->keep_directory = _tmp25_;
	_tmp26_ = builder;
	_tmp27_ = gtk_builder_get_object (_tmp26_, "file_pattern_entry");
	_tmp28_ = _g_object_ref0 (G_TYPE_CHECK_INSTANCE_TYPE (_tmp27_, gtk_entry_get_type ()) ? ((GtkEntry*) _tmp27_) : NULL);
	_g_object_unref0 (self->priv->file_pattern);
	self->priv->file_pattern = _tmp28_;
	_tmp29_ = self->priv->all_files;
	_tmp30_ = gtk_radio_button_get_group (_tmp29_);
	group = _tmp30_;
	_tmp31_ = self->priv->selected_files;
	_tmp32_ = group;
	gtk_radio_button_set_group (_tmp31_, _tmp32_);
	_tmp33_ = self->priv->listed_files;
	_tmp34_ = group;
	gtk_radio_button_set_group (_tmp33_, _tmp34_);
	_tmp35_ = type;
	switch (_tmp35_) {
		case 0:
		{
			GtkRadioButton* _tmp36_ = NULL;
			_tmp36_ = self->priv->all_files;
			gtk_toggle_button_set_active ((GtkToggleButton*) _tmp36_, TRUE);
			break;
		}
		case 1:
		{
			GtkRadioButton* _tmp37_ = NULL;
			_tmp37_ = self->priv->selected_files;
			gtk_toggle_button_set_active ((GtkToggleButton*) _tmp37_, TRUE);
			break;
		}
		case 2:
		{
			GtkRadioButton* _tmp38_ = NULL;
			_tmp38_ = self->priv->listed_files;
			gtk_toggle_button_set_active ((GtkToggleButton*) _tmp38_, TRUE);
			break;
		}
		default:
		break;
	}
	_g_object_unref0 (content);
	_g_object_unref0 (option_box);
	_g_object_unref0 (builder);
	return self;
}


ExtractDialog* extract_dialog_new (GtkWindow* window, gint type) {
	return extract_dialog_construct (TYPE_EXTRACT_DIALOG, window, type);
}


gboolean extract_dialog_keep_structure (ExtractDialog* self) {
	gboolean result = FALSE;
	GtkCheckButton* _tmp0_ = NULL;
	gboolean _tmp1_ = FALSE;
	g_return_val_if_fail (self != NULL, FALSE);
	_tmp0_ = self->priv->keep_directory;
	_tmp1_ = gtk_toggle_button_get_active ((GtkToggleButton*) _tmp0_);
	result = _tmp1_;
	return result;
}


gboolean extract_dialog_keep_old_files (ExtractDialog* self) {
	gboolean result = FALSE;
	GtkCheckButton* _tmp0_ = NULL;
	gboolean _tmp1_ = FALSE;
	g_return_val_if_fail (self != NULL, FALSE);
	_tmp0_ = self->priv->overwrite_file;
	_tmp1_ = gtk_toggle_button_get_active ((GtkToggleButton*) _tmp0_);
	result = _tmp1_;
	return result;
}


gchar* extract_dialog_get_pattern (ExtractDialog* self) {
	gchar* result = NULL;
	GtkEntry* _tmp0_ = NULL;
	const gchar* _tmp1_ = NULL;
	gchar* _tmp2_ = NULL;
	g_return_val_if_fail (self != NULL, NULL);
	_tmp0_ = self->priv->file_pattern;
	_tmp1_ = gtk_entry_get_text (_tmp0_);
	_tmp2_ = g_strdup (_tmp1_);
	result = _tmp2_;
	return result;
}


gint extract_dialog_get_extract_option (ExtractDialog* self) {
	gint result = 0;
	GtkRadioButton* _tmp0_ = NULL;
	gboolean _tmp1_ = FALSE;
	GtkRadioButton* _tmp2_ = NULL;
	gboolean _tmp3_ = FALSE;
	g_return_val_if_fail (self != NULL, 0);
	_tmp0_ = self->priv->selected_files;
	_tmp1_ = gtk_toggle_button_get_active ((GtkToggleButton*) _tmp0_);
	if (_tmp1_) {
		result = 1;
		return result;
	}
	_tmp2_ = self->priv->listed_files;
	_tmp3_ = gtk_toggle_button_get_active ((GtkToggleButton*) _tmp2_);
	if (_tmp3_) {
		result = 2;
		return result;
	}
	result = 0;
	return result;
}


static void extract_dialog_class_init (ExtractDialogClass * klass) {
	extract_dialog_parent_class = g_type_class_peek_parent (klass);
	g_type_class_add_private (klass, sizeof (ExtractDialogPrivate));
	G_OBJECT_CLASS (klass)->finalize = extract_dialog_finalize;
}


static void extract_dialog_instance_init (ExtractDialog * self) {
	self->priv = EXTRACT_DIALOG_GET_PRIVATE (self);
}


static void extract_dialog_finalize (GObject* obj) {
	ExtractDialog * self;
	self = G_TYPE_CHECK_INSTANCE_CAST (obj, TYPE_EXTRACT_DIALOG, ExtractDialog);
	_g_object_unref0 (self->priv->overwrite_file);
	_g_object_unref0 (self->priv->keep_directory);
	_g_object_unref0 (self->priv->all_files);
	_g_object_unref0 (self->priv->selected_files);
	_g_object_unref0 (self->priv->listed_files);
	_g_object_unref0 (self->priv->file_pattern);
	G_OBJECT_CLASS (extract_dialog_parent_class)->finalize (obj);
}


GType extract_dialog_get_type (void) {
	static volatile gsize extract_dialog_type_id__volatile = 0;
	if (g_once_init_enter (&extract_dialog_type_id__volatile)) {
		static const GTypeInfo g_define_type_info = { sizeof (ExtractDialogClass), (GBaseInitFunc) NULL, (GBaseFinalizeFunc) NULL, (GClassInitFunc) extract_dialog_class_init, (GClassFinalizeFunc) NULL, NULL, sizeof (ExtractDialog), 0, (GInstanceInitFunc) extract_dialog_instance_init, NULL };
		GType extract_dialog_type_id;
		extract_dialog_type_id = g_type_register_static (gtk_file_chooser_dialog_get_type (), "ExtractDialog", &g_define_type_info, 0);
		g_once_init_leave (&extract_dialog_type_id__volatile, extract_dialog_type_id);
	}
	return extract_dialog_type_id__volatile;
}



